From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 15:56:58 +0100
Message-ID: <200902171557.02149.oliver__43833.5050982007$1234882659$gmane$org@neukum.org>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<20090217142001.GB12378@bulgaria.corp.google.com>
	<20090217142453.GA25530@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090217142453.GA25530@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Brian Swetland <swetland@google.com>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Am Tuesday 17 February 2009 15:24:53 schrieb Matthew Garrett:
> On Tue, Feb 17, 2009 at 06:20:01AM -0800, Brian Swetland wrote:
> 
> > Of course that still doesn't address userspace.  Aggressively going to
> > suspend lets us compensate for userspace programs that do somewhat silly
> > things (I agree that it would be best if they didn't but they do and
> > getting *everyone* to write their userspace code to avoid spinning or
> > avoid waking up on short-duration timers to poll is a losing battle).
> 
> Like Pavel pointed out, you could (in principle) handle this by sending 
> a SIGSTOP to everything. The obvious problem with doing so is that this 
> wouldn't result in the processes letting go of the devices, so you 
> wouldn't neccessarily actually get to enter the runtime idle state as a 
> result. Hmm. I'll think about this.

They don't let go of the devices if you suspend either. If you want that
you need active cooperation from user space. In fact if you suspend you
give drivers the guarantee of not getting any output without prior
notification, making their lives easier.

	Regards
		Oliver
