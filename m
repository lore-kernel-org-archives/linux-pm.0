From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -mm 1/2] kexec jump -v12: kexec jump
Date: Fri, 11 Jul 2008 12:21:31 -0700
Message-ID: <20080711122131.b6461ab1.akpm__4049.93540510095$1215804289$gmane$org@linux-foundation.org>
References: <1215401122.4660.4.camel@caritas-dev.intel.com>
	<20080708145051.GA14745@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080708145051.GA14745@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Kexec@smtp1.linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Jul 2008 10:50:51 -0400 Vivek Goyal <vgoyal@redhat.com> wrote:

> On Mon, Jul 07, 2008 at 11:25:22AM +0800, Huang Ying wrote:
> > This patch provides an enhancement to kexec/kdump. It implements
> > the following features:
> > 
> > - Backup/restore memory used by the original kernel before/after
> >   kexec.
> > 
> > - Save/restore CPU state before/after kexec.
> > 
> 
> Hi Huang,
> 
> In general this patch set looks good enough to live in -mm and
> get some testing going.
> 
> To me, adding capability to return back to original kernel looks
> like a logical extension to kexec functionality.

Exciting ;)  It's much less code than I expected.

I don't think I understand the feature any more.  Once upon a time we
thought that this might become a new and better (or at least
better-code-sharing) way of doing suspend-to-disk.  How far are we from
that?

What are the prospects of supporting other architectures?

Who maintains kexec-tools, and are they OK with merging up the
corresponding changes?

Thanks.
