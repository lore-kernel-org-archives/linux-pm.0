From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Thu, 13 Mar 2008 18:03:29 +0100
Message-ID: <200803131803.31120.rjw__5164.24103775552$1205428042$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
	<200803122253.07631.rjw@sisk.pl>
	<m1iqzrxy26.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1iqzrxy26.fsf@ebiederm.dsl.xmission.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, 13 of March 2008, Eric W. Biederman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > Yes, it ought to be possible.
> >
> > Ultimately, IMHO, we should put all devices unnecessary for saving the image
> > (and doing some eye-candy work) into low power states before the image is
> > created and keep them in low power states until the system is eventually
> > powered off.
> 
> Why?  I guess I don't see why we care what power state the devices are in.
> Especially since we should be able to quickly save the image.
> 
> We need to disconnect the drivers from the hardware yes.  So filesystems
> still work and applications that do direct hardware access still work
> and don't need to reopen their connections.
> 
> I'm leery of low power states as they don't always work, and bringing
> low power states seems to confuse hibernation to disk with suspend to
> ram.

>From the ACPI compliance point of view it's better to do it this way.  We need
to put the devices into low power states anyway before "powering off" the
system and we won't need to touch them for the second time if we do that
in advance.

Still, it would be sufficient if we disconnected the drivers from the hardware
and thus prevented applications from accessing that hardware.

Thanks,
Rafael
