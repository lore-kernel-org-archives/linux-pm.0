From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 20 Apr 2012 20:42:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204202037570.19313-100000@netrider.rowland.org>
References: <20120419214856.GC11484@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120419214856.GC11484@belkar.wrar.name>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: jrnieder@gmail.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 20 Apr 2012, Andrey Rahmatullin wrote:

> > I'd like to see the dmesg log for the complete suspend/resume cycle 
> > (naturally you'll have to resume the system by hand after plugging in 
> > the USB device).  Make sure that CONFIG_USB_DEBUG is enabled.
> Attached.

It looks quite normal.  Evidently USB wakeup does _not_ work on your 
system when the controller isn't in D3 -- and the system crashes during 
suspend if the controller _is_ in D3!

(Does anybody know if USB wakeup works on these machines under
Windows?)

What about runtime wakeup?  You can test it easily enough.  Write 
"auto" to the power/control attribute for the two controllers.  This 
should cause the controllers (or at least one of them) to go into 
runtime suspend.  Does it then wake up when you plug in a USB device?

Alan Stern
