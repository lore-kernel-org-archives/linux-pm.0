From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 17:12:42 +0100
Message-ID: <20070528161242.GA1063@srcf.ucam.org>
References: <20070527220158.GB22687@srcf.ucam.org>
	<Pine.LNX.4.44L0.0705281156470.22682-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0705281156470.22682-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 28, 2007 at 12:09:30PM -0400, Alan Stern wrote:

> I can't speak for the second example, but there's a good reason the
> first example works this way.  It's not a matter of races; the problem
> is that the kernel thread's job is to selectively suspend and resume
> devices.  We don't want it doing this while a system sleep is in 
> progress; it would (and in fact has, before the thread was made 
> freezable) cause the sleep transition to abort.

How does this work on PPC or APM systems?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
