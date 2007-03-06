From: David Rientjes <rientjes@google.com>
Subject: Re: [RFC] [PATCH] Power Managed memory base enabling
Date: Tue, 6 Mar 2007 09:33:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703060925550.27341@chino.kir.corp.google.com>
References: <20070305181826.GA21515@linux.intel.com>
	<Pine.LNX.4.64.0703051941310.18703@chino.kir.corp.google.com>
	<20070306164722.GB22725@linux.intel.com>
	<Pine.LNX.4.64.0703060904380.27341@chino.kir.corp.google.com>
	<20070306172039.GA26038@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070306172039.GA26038@linux.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Mark Gross <mgross@linux.intel.com>
Cc: linux-mm@kvack.org, mark.gross@intel.com, linux-pm@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, neelam.chandwani@intel.com
List-Id: linux-pm@vger.kernel.org

On Tue, 6 Mar 2007, Mark Gross wrote:

> > Is do_migrate_pages() currently unsatisfactory for this?
> =

> This looks like it should be good for this application!  How stable is
> this?  The next phase of this work is to export the policy interfaces
> and hook up the page migration.  I'm somewhat new to the mm code.
> =


Since you've already used a NUMA approach to flagging PM-memory, you'd =

probably want to use this interface through mempolicy in your migration.  =

There's currently work to do lockless VMA scanning that was posted just =

yesterday to linux-mm and that's a bottleneck in this migration.

Take a look at update_nodemask() in kernel/cpuset.c for how it migrates =

pages from a source set of nodes to a destination set using =

memory_migrate.  The cpuset specifics are explained in =

Documentation/cpusets.txt, but the basics are that you'll want to use =

memory_migrate to start the migration when you remove a node from your =

nodemask (another reason why I suggested the use of a nodemask instead of =

a simple array).

		David
