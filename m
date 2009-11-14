From: Jiri Slaby <jirislaby@gmail.com>
Subject: resume crashes in intel_init_thermal [was: mmotm
 2009-11-13-19-59 uploaded]
Date: Sat, 14 Nov 2009 14:28:00 +0100
Message-ID: <4AFEB060.80007__17010.9186591164$1258205365$gmane$org@gmail.com>
References: <200911140403.nAE43CN1016851@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911140403.nAE43CN1016851@imap1.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, the arch/x86 maintainers <x86@kernel.org>, mm-commits@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 11/14/2009 05:03 AM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2009-11-13-19-59 has been uploaded to

Hi, resume from ram dies in intel_init_thermal in that kernel:
http://www.fi.muni.cz/~xslaby/sklad/mce_oops.png

The code is cc cc cc cc ... KGDB and KPROBES are off, I don't know where
the pattern may come from.

Does it ring a bell? Any ideas? mmotm 2009-11-01-10-01 was OK.

thanks,
-- 
js
Faculty of Informatics, Masaryk University
Suse Labs, Novell
