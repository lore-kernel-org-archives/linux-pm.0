From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] Power domains for platform bus type
Date: Mon, 31 Jan 2011 22:40:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101312235190.11313-100000__49792.8938515999$1296531827$gmane$org@netrider.rowland.org>
References: <871v3s3ahe.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <871v3s3ahe.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 31 Jan 2011, Kevin Hilman wrote:

> For the on-chip SoC devices we're managing with OMAP, we're currently
> only using one set: post ops on [runtime_]suspend and pre ops on
> [runtime_]resume.
> 
> However, I could imagine (at least conceptually) using the pre ops on
> suspend to do some constraints checking and/or possibly some
> management/notification of dependent devices.  Another possiblity
> (although possibly racy) would be using the pre ops on suspend to
> initiate some high-latency operations.

Dependency management is very relevant here, since we're talking about
relations that explicitly aren't of the parent-child type.  If any of
the devices in question get marked for async suspend/resume, for
example, they certainly will need dependency handling.

> I guess the main problem with two sets is wasted space.  e.g, if I move
> OMAP to this (already hacking on it) there will be only 2 functions used
> in post ops: [runtime_]suspend() and 2 used in pre ops [runtime_]_resume().

The wasted space is minimal; we're only talking about one extra pm_ops
structure for each power domain.  Presumably any reasonable SoC isn't
going to have a tremendous number of separate power domains.  Or am I
wrong about this?

Alan Stern
