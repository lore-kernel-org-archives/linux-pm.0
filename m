From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 17:16:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707031713530.8010-100000__19259.8523376093$1183497760$gmane$org@iolanthe.rowland.org>
References: <20070703211227.GA28758@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070703211227.GA28758@srcf.ucam.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 3 Jul 2007, Matthew Garrett wrote:

> On Tue, Jul 03, 2007 at 05:10:08PM -0400, Alan Stern wrote:
> 
> > No, no -- you have it exactly backwards.  Removing the freezer turns 
> > STR into something _less_ like runtime suspend, because it adds the 
> > requirement that devices must not automatically be resumed when an I/O 
> > request arrives.
> 
> But that's fine - "Are we undergoing a systemwide suspend" is an easy 
> question to ask. Freezing processes instead means that most of those 
> paths will never be tested.

The question is easy to ask, but it's not so easy to figure out what
you should do if the answer is Yes.  Freezing processes instead means
that those "untested" paths -- in many, many drivers -- won't have to 
exist at all.

Alan Stern
