From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 22:20:02 +0100
Message-ID: <20070703212002.GA28895@srcf.ucam.org>
References: <20070703211227.GA28758@srcf.ucam.org>
	<Pine.LNX.4.44L0.0707031713530.8010-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0707031713530.8010-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 03, 2007 at 05:16:37PM -0400, Alan Stern wrote:
> On Tue, 3 Jul 2007, Matthew Garrett wrote:
> > But that's fine - "Are we undergoing a systemwide suspend" is an easy 
> > question to ask. Freezing processes instead means that most of those 
> > paths will never be tested.
> 
> The question is easy to ask, but it's not so easy to figure out what
> you should do if the answer is Yes.  Freezing processes instead means
> that those "untested" paths -- in many, many drivers -- won't have to 
> exist at all.

We're used to the idea of applications blocking when a resource they're 
using goes away - NFS has done it forever. 

-- 
Matthew Garrett | mjg59@srcf.ucam.org
