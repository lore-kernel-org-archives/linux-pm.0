From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] pm: rename device_power_down/up()
Date: Thu, 14 May 2009 22:00:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905142159250.25076-100000@netrider.rowland.org>
References: <200905150111.01896.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905150111.01896.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Greg KH <gregkh@suse.de>, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 15 May 2009, Rafael J. Wysocki wrote:

> On Thursday 14 May 2009, Len Brown wrote:
> > I agree with Alan,
> > 
> > ACK on the 1st patch,
> 
> Applied to the suspend tree.
> 
> > and lets follow it up so we're not in the funky state where we have
> > both device_resume() and resume_device() etc. at the same time.
> 
> Works for me. :-)

And as the instigator, I get to write the second patch, eh?  :-)
Okay...  I'll work on it tomorrow.

Alan Stern
