From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 15:39:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902161537080.19732-100000__42978.9092894227$1234816990$gmane$org@netrider.rowland.org>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kyle Moffett <kyle@moffetthome.net>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Feb 2009, Kyle Moffett wrote:

> Userspace may not have a useful decision-making capability regarding
> functionality versus power-saving, but the user it's talking to might!
> 
> I think it would be very useful to have a mechanism for userspace to
> find out "Link detection on this NIC costs ~50mW" and "No link has
> been detected for the last 15 minutes", so that it can compile all
> that sort of information and prompt the user what devices they would
> like to disable.  Perhaps an "airline mode" sort of thing?

Even if drivers don't know how much power their devices consume (and
generally I wouldn't expect them to), it still makes sense to offer
userspace the discretionary power to force devices into a low-power
mode.  USB does this.

Alan Stern
