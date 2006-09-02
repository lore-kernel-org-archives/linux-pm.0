From: Greg KH <greg@kroah.com>
Subject: Re: [patch 2.6.18-rc-mm] PM: platform_bus and
	late_suspend/early_resume
Date: Fri, 1 Sep 2006 21:04:44 -0700
Message-ID: <20060902040444.GA18087@kroah.com>
References: <20060902035114.4C154195C8B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060902035114.4C154195C8B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: torvalds@osdl.com.kroah.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 01, 2006 at 08:51:14PM -0700, David Brownell wrote:
> =

> Teach platform_bus about the new suspend_late/resume_early PM calls,
> issued with IRQs off.  Do we really need sysdev and friends any more,
> or can janitors start switching its users over to platform_device so
> we can do a minor code-ectomy?

I don't think we need it anymore, but you should ask the cpu people,
they seem to love sysdev for some odd reason (probably because they
finally get to create a sysfs file, like all the cool driver kids have
been doing for years...)

If you get their ok, I'm fine with getting rid of it.

thanks,

greg k-h
