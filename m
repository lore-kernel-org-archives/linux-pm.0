From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] doc/power: move power-related files to
	Documentation/power/
Date: Wed, 12 Mar 2008 17:49:37 -0400
Message-ID: <200803121749.37889.lenb__48630.5880629972$1205358789$gmane$org@kernel.org>
References: <20080304134837.dcfed6dd.randy.dunlap@oracle.com>
	<200803121600.45535.lenb@kernel.org>
	<20080312144110.113c853b.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080312144110.113c853b.randy.dunlap@oracle.com>
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
> On Wed, 12 Mar 2008 16:00:45 -0400 Len Brown wrote:
> 
> > linus top of tree.  i was wrong that it was already gone,
> > i guess i assumed that since it had 1 hunk and patch
> > told me the hunk was reversed i assumed that part
> > had been applied already.
> 
> Can you try the patch below?
> It works_for_me but that doesn't give me lots of confidence.
> 
> ---
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Move power-related files to Documentation/power/.
> 
> Move 00-INDEX entries to power/00-INDEX (and add entry for
> pm_qos_interface.txt).
> 
> Update references to moved filenames.
> 
> Fix some trailing whitespace.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  Documentation/00-INDEX                     |    4 
>  Documentation/kernel-parameters.txt        |    2 
>  Documentation/pm.txt                       |  257 -------------------
>  Documentation/pm_qos_interface.txt         |   59 ----
>  Documentation/power/00-INDEX               |    6 
>  Documentation/power/pm.txt                 |  257 +++++++++++++++++++
>  Documentation/power/pm_qos_interface.txt   |   59 ++++
>  Documentation/power/power_supply_class.txt |  169 ++++++++++++
>  Documentation/power_supply_class.txt       |  169 ------------
>  arch/x86/Kconfig                           |    2 
>  kernel/power/Kconfig                       |    2 
>  11 files changed, 494 insertions(+), 492 deletions(-)
> 

not better

Please send it to me as an attachment,
maybe kmail is getting confused b/c this text has non ascii characters?

(does this patch apply for anybody else?)

thanks,
-Len

[lenb@t61 linus (master)]$ patch -Np1 --dry-run < ~/Documents/doc-new.patch
patching file Documentation/00-INDEX
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
patching file kernel/power/Kconfig
patching file Documentation/kernel-parameters.txt
[lenb@t61 linus (master)]$   
