From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] doc/power: move power-related files to
	Documentation/power/
Date: Wed, 12 Mar 2008 16:00:45 -0400
Message-ID: <200803121600.45535.lenb__9642.79268305308$1205352268$gmane$org@kernel.org>
References: <20080304134837.dcfed6dd.randy.dunlap@oracle.com>
	<200803120247.27649.lenb@kernel.org>
	<20080312093350.785d6cde.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080312093350.785d6cde.randy.dunlap@oracle.com>
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
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, dwmw2@infradead.org, cbou@mail.ru
List-Id: linux-pm@vger.kernel.org

On Wednesday 12 March 2008, Randy Dunlap wrote:
> On Wed, 12 Mar 2008 02:47:27 -0400 Len Brown wrote:
> 
> > On Tuesday 04 March 2008, Randy Dunlap wrote:
> > > From: Randy Dunlap <randy.dunlap@oracle.com>
> > > 
> > > Move power-related files to Documentation/power/.
> > > 
> > > Move 00-INDEX entries to power/00-INDEX (and add entry for
> > > pm_qos_interface.txt).
> > > 
> > > Update references to moved filenames.
> > > 
> > > Fix some trailing whitespace.
> > > 
> > > Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> > > ---
> > >  Documentation/00-INDEX                     |    4 
> > >  Documentation/kernel-parameters.txt        |    2 
> > >  Documentation/pm.txt                       |  257 -------------------
> > >  Documentation/pm_qos_interface.txt         |   59 ----
> > >  Documentation/power/00-INDEX               |    6 
> > >  Documentation/power/pm.txt                 |  257 +++++++++++++++++++
> > >  Documentation/power/pm_qos_interface.txt   |   59 ++++
> > >  Documentation/power/power_supply_class.txt |  169 ++++++++++++
> > >  Documentation/power_supply_class.txt       |  169 ------------
> > >  arch/x86/Kconfig                           |    2 
> > >  kernel/power/Kconfig                       |    2 
> > >  11 files changed, 494 insertions(+), 492 deletions(-)
> > 
> > Randy,
> > This one doesn't apply any more.
> > somebody already remove the power_supply_class.txt file?
> 
> Don't think so, but I can't reproduce the problem.
> What kernel tree are you applying it to?
> 

linus top of tree.  i was wrong that it was already gone,
i guess i assumed that since it had 1 hunk and patch
told me the hunk was reversed i assumed that part
had been applied already.

[lenb@t61 linus (master)]$ patch -Np1 --dry-run <  ~/Documents/doc1.patch
patching file Documentation/00-INDEX
Hunk #1 succeeded at 301 (offset -2 lines).
patching file Documentation/power/00-INDEX
patching file Documentation/pm.txt
patching file Documentation/power/pm.txt
patching file Documentation/pm_qos_interface.txt
patching file Documentation/power/pm_qos_interface.txt
patching file Documentation/power/power_supply_class.txt
patching file Documentation/power_supply_class.txt
Reversed (or previously applied) patch detected!  Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file Documentation/power_supply_class.txt.rej
patching file arch/x86/Kconfig
Hunk #1 succeeded at 1259 (offset -2 lines).
patching file kernel/power/Kconfig
patching file Documentation/kernel-parameters.txt


git-am didn't do any better:

Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all y
Applying doc/power: move power-related files to Documentation/power/
error: patch failed: Documentation/power_supply_class.txt:1
error: Documentation/power_supply_class.txt: patch does not apply
fatal: sha1 information is lacking or useless (Documentation/00-INDEX).
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
Patch failed at 0001.
When you have resolved this problem run "git-am -i -3 --resolved".
If you would prefer to skip this patch, instead run "git-am -i -3 --skip".
                 
