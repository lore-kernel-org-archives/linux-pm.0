From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation breaks between 2.6.23 and 2.6.24 on Acer
	Aspire 1690
Date: Mon, 5 Jan 2009 20:53:22 +0100
Message-ID: <200901052053.22599.rjw@sisk.pl>
References: <524512.7403.qm@web36807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <524512.7403.qm@web36807.mail.mud.yahoo.com>
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
To: linux-pm@lists.linux-foundation.org, dqarras@yahoo.com
List-Id: linux-pm@vger.kernel.org

On Monday 05 January 2009, Daniel Qarras wrote:
> Hi all,
> 
> I've got Fedora 10 on Acer Aspire 1690 (1692 WLMi to be exact) and some time ago I noticed that pm-hibernate has the following problem:
> 
> pm-hibernate runs ok and cleanly shuts down the machine that at the very moment it is supposed to be hibernated it wakes up and resumes as if I had pressed the power button.
> 
> I compiled few kernel.org kernels and noticed this starts to occur between 2.6.23 and 2.6.24. 2.6.23 and all older versions work, 2.6.24 and new versions fail, including 2.6.28.
> 
> Does anyone have any suggestions what might be causing this? I mean, could I try some boot parameter or some simple patch before starting to bisect this?

Unfortunately, that's quite a few kernel versions back.  I'm afraid we won't be
able to resolve this without knowing which patch broke it for you.

Thanks,
Rafael
