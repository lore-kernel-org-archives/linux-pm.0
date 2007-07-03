From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 23:42:15 +0100
Message-ID: <20070703224215.GA30081__36783.1536838368$1183502826$gmane$org@srcf.ucam.org>
References: <20070703212002.GA28895@srcf.ucam.org>
	<Pine.LNX.4.44L0.0707031814440.8010-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0707031814440.8010-100000@iolanthe.rowland.org>
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

On Tue, Jul 03, 2007 at 06:21:42PM -0400, Alan Stern wrote:
> On Tue, 3 Jul 2007, Matthew Garrett wrote:
> > We're used to the idea of applications blocking when a resource they're 
> > using goes away - NFS has done it forever. 
> 
> You persist in evading my point.  I'm not worried about applications;  
> I'm worried about drivers.
> 
> Let me put it explicitly: You're writing a driver.  You're working on
> the read, write, or probe method.  You add code to check if a system
> sleep is underway.  Suppose the answer is Yes -- what does your driver
> do next?

Leave the process blocked and defer any i/o until after resume. Why does 
it need to be any more complicated than that?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
