From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while
	suspended (rev. 2)
Date: Sat, 12 Jan 2008 04:15:06 +0100
Message-ID: <200801120415.07176.ak__35784.2919337147$1200107793$gmane$org@suse.de>
References: <Pine.LNX.4.44L0.0801112208030.21411-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801112208030.21411-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pavel@suse.cz, tglx@linutronix.de, mingo@elte.hu, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> The real problem is that our current email workflow patterns don't 
> provide a standardized way for maintainers to tell when a new patch 
> submission is meant to override or replace an earlier submission (or 
> even a set of earlier submissions).  Does anybody have some suggestions 
> for a good way to do this?

The versioning approach pioneered by Christoph Lameter seems to work
reasonably well.

If you post a new version increase a version number and add it with "vXXX" to the
Subject.

Also add a short change log between versions at the bottom; e.g. v1->v2: .... etc.

Then it is always clear what is the latest'n'greatest.

-Andi
