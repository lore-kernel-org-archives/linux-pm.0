From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 0/6] ARM: runtime PM: consolidate runtime
	PM implementations
Date: Thu, 07 Apr 2011 10:17:03 -0700
Message-ID: <87hbaa7zhs.fsf__40766.1710669801$1302196942$gmane$org@ti.com>
References: <1302134569-22825-1-git-send-email-khilman@ti.com>
	<201104070738.42956.rjw@suse.com> <871v1eaz0u.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <871v1eaz0u.fsf@ti.com> (Kevin Hilman's message of "Thu, 07 Apr
	2011 07:58:57 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@suse.com>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Kevin Hilman <khilman@ti.com> writes:

[...]

> Replacing the PM ops for all devices was done on OMAP and SH-mobile
> because that was the only approach we had.  Now that we have device
> power domains (thanks Rafael!), we can be more selective about which
> devices to apply them to.
>
> Note that my RFC patch/series did not do the selective part of deciding
> which devices to override and which ones not to, that part will be
> platform specific.  

Actually, thinking about this a little more, my patch actually does
select only relevant devices, and not *all* platform devices.

In my patch, the device power domain pointers are only added for devices
where a clk_get() actually succeeds.  In the original version, the
runtime PM hooks are overridden for *all* platform devices, but ones
that have no clock (or where clk_get() failed) have the additional
overhead of still calling the custom PM ops, but the custom ops have
nothing to do.

Kevin
