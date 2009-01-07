From: Daniel Qarras <dqarras@yahoo.com>
Subject: Re: Hibernation breaks between 2.6.23 and 2.6.24 on Acer
	Aspire 1690
Date: Wed, 7 Jan 2009 15:13:03 -0800 (PST)
Message-ID: <208038.77798.qm@web36806.mail.mud.yahoo.com>
References: <200901072358.26930.rjw@sisk.pl>
Reply-To: dqarras@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901072358.26930.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Please find lspci -vvv output from my Fedora bug report:
> > 
> > https://bugzilla.redhat.com/attachment.cgi?id=326874
> 
> OK, please check if it is sufficient to unload ehci-hcd
> and/or uhci-hcd before hibernation.

It is sufficient to unload ehci-hcd. Unloading uhci-hcd does not help.

Thanks!



      
