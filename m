From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 20 Apr 2012 20:53:44 -0400
Message-ID: <1334969624.28106.82.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204202037570.19313-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204202037570.19313-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jrnieder@gmail.com, Andrey Rahmatullin <wrar@wrar.name>, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2012-04-20 at 20:42 -0400, Alan Stern wrote:

> (Does anybody know if USB wakeup works on these machines under
> Windows?)

I still have my windows partition on this box. Do you happen to know how
to tell Windows to wake up on USB?

> 
> What about runtime wakeup?  You can test it easily enough.  Write 
> "auto" to the power/control attribute for the two controllers.  This 
> should cause the controllers (or at least one of them) to go into 
> runtime suspend.  Does it then wake up when you plug in a USB device?

Do you want me to do this with one of you patches, or with the script
applied?

-- Steve
