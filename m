From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 4/5] x86 idle: move mwait_idle_with_hints()
 to where it is used
Date: Wed, 03 Aug 2011 15:36:02 -0700
Message-ID: <4E39CD52.9040504__20399.7222859927$1312411017$gmane$org@zytor.com>
References: <1312400648-17636-1-git-send-email-lenb@kernel.org>
	<779d881fbcdf840e23a9bd3e237aebca4e0376e8.1312400543.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <779d881fbcdf840e23a9bd3e237aebca4e0376e8.1312400543.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/03/2011 12:44 PM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> ...and make it static
> 
> no functional change
> 
> cc: x86@kernel.org
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/include/asm/processor.h |    2 --
>  arch/x86/kernel/acpi/cstate.c    |   23 +++++++++++++++++++++++
>  arch/x86/kernel/process.c        |   23 -----------------------
>  3 files changed, 23 insertions(+), 25 deletions(-)
> 

Acked-by: H. Peter Anvin <hpa@linux.intel.com>
