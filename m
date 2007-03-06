From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [RFC] [PATCH] Power Managed memory base enabling
Date: Tue, 6 Mar 2007 10:26:28 +0900
Message-ID: <20070306102628.4c32fc65.kamezawa.hiroyu@jp.fujitsu.com>
References: <20070305181826.GA21515@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070305181826.GA21515@linux.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: mgross@linux.intel.com
Cc: linux-mm@kvack.org, mark.gross@intel.com, linux-pm@lists.osdl.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, neelam.chandwani@intel.com
List-Id: linux-pm@vger.kernel.org

On Mon, 5 Mar 2007 10:18:26 -0800
Mark Gross <mgross@linux.intel.com> wrote:

> It implements a convention on the 4 bytes of "Proximity Domain ID"
> within the SRAT memory affinity structure as defined in ACPI3.0a.  If
> bit 31 is set, then the memory range represented by that PXM is assumed
> to be power managed.  We are working on defining a "standard" for
> identifying such memory areas as power manageable and progress committee
> based.  =

> =


This usage of bit 31 surprized me ;)
I think some vendor(sgi?) now using 4byte pxm...
no problem ? and othre OSs will handle this ?

-Kame
