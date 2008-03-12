From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] doc/power: move power-related files to
	Documentation/power/
Date: Wed, 12 Mar 2008 02:47:27 -0400
Message-ID: <200803120247.27649.lenb__28578.3914187506$1205304711$gmane$org@kernel.org>
References: <20080304134837.dcfed6dd.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080304134837.dcfed6dd.randy.dunlap@oracle.com>
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, cbou@mail.ru, dwmw2@infradead.org, len.brown@intel.com
List-Id: linux-pm@vger.kernel.org

On Tuesday 04 March 2008, Randy Dunlap wrote:
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

Randy,
This one doesn't apply any more.
somebody already remove the power_supply_class.txt file?

-Len
