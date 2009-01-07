From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation breaks between 2.6.23 and 2.6.24 on Acer
	Aspire 1690
Date: Thu, 8 Jan 2009 00:45:07 +0100
Message-ID: <200901080045.07815.rjw@sisk.pl>
References: <208038.77798.qm@web36806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <208038.77798.qm@web36806.mail.mud.yahoo.com>
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
To: dqarras@yahoo.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 08 January 2009, Daniel Qarras wrote:
> Hi!
> 
> > > Please find lspci -vvv output from my Fedora bug report:
> > > 
> > > https://bugzilla.redhat.com/attachment.cgi?id=326874
> > 
> > OK, please check if it is sufficient to unload ehci-hcd
> > and/or uhci-hcd before hibernation.
> 
> It is sufficient to unload ehci-hcd. Unloading uhci-hcd does not help.

Thanks for verifying.

I think we'll need to use a blacklist to work around this issue, but I need to
discuss this with other people.

Please ping me if I don't get back to you for some time.

Thanks,
Rafael
