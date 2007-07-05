From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: The big suspend mess
Date: Thu, 5 Jul 2007 10:14:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707051013170.3728-100000@iolanthe.rowland.org>
References: <20070704221952.GM3492@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070704221952.GM3492@stusta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 5 Jul 2007, Adrian Bunk wrote:

> IMHO the suspend code is currently way too much of a moving target which 
> results in this mess.
> 
> The correct order seems to be:
> 1. agree on what the suspend code as a whole should look like
> 2. implement this
> 3. fix ALL drivers to work at least as good as they do today
> 4. get it tested in -mm
> 5. fix all bugs people run into
> 6. submit it for inclusion in Linus' tree
> 7. quickly work on the most likely big amount of bug reports
> 
> Step 1 is the most important one - evolving code is often something 
> good, but in this case with different people trying to evolve the 
> suspend code in different directions it simply results in a big mess.

Isn't Step 1 exactly what we are in the midst of right now?

Alan Stern
