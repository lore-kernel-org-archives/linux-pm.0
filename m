From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: resume crashes in intel_init_thermal [was: mmotm
 2009-11-13-19-59 uploaded]
Date: Sat, 14 Nov 2009 19:44:36 +0100
Message-ID: <4AFEFA94.8060207__18807.0682147101$1258224365$gmane$org@gmail.com>
References: <200911140403.nAE43CN1016851@imap1.linux-foundation.org>	<4AFEB060.80007@gmail.com>
	<20091114081549.1477fabc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091114081549.1477fabc.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Brown, Len" <len.brown@intel.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Yong Wang <yong.y.wang@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 11/14/2009 05:15 PM, Andrew Morton wrote:
> Revert
> 
> : commit ce6b5d768c79b9d5dd6345c033bae781d5ca9b8e
> : Author:     Yong Wang <yong.y.wang@linux.intel.com>
> : AuthorDate: Wed Nov 11 15:51:25 2009 +0800
> : Commit:     Ingo Molnar <mingo@elte.hu>
> : CommitDate: Wed Nov 11 12:33:32 2009 +0100
> : 
> :     x86: Mark the thermal init functions __init
> 
> because intel_init_thermal() is called from mce_intel_feature_init() at
> resume time, and we'd like its text to still be in memory when that
> happens.

Works for me. Thanks.

-- 
js
Faculty of Informatics, Masaryk University
Suse Labs, Novell
