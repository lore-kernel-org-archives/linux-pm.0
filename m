From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation breaks between 2.6.23 and 2.6.24 on Acer
	Aspire 1690
Date: Wed, 7 Jan 2009 23:58:26 +0100
Message-ID: <200901072358.26930.rjw@sisk.pl>
References: <381669.91029.qm@web36807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <381669.91029.qm@web36807.mail.mud.yahoo.com>
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

On Wednesday 07 January 2009, Daniel Qarras wrote:
> Hi!
>  
> > > Tested with 2.6.28 with all USB related modules
> > > unloaded and, as if by magic, hibernation worked! :)
> > 
> > IIRC, it should be sufficient to unload ehci-hcd.
> > 
> > It is a chipset issue rather than anything else.
> > 
> > Please send the output of lspci -vv
> 
> Please find lspci -vvv output from my Fedora bug report:
> 
> https://bugzilla.redhat.com/attachment.cgi?id=326874

OK, please check if it is sufficient to unload ehci-hcd and/or uhci-hcd before
hibernation.

Thanks,
Rafael
