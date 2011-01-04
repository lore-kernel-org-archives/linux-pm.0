From: Jiri Slaby <jirislaby@gmail.com>
Subject: suspend hangs at platform phase [was: mmotm
	2010-12-23-16-58 uploaded]
Date: Tue, 04 Jan 2011 14:40:34 +0100
Message-ID: <4D232352.2030809__38789.3244078898$1294148504$gmane$org@gmail.com>
References: <201012240132.oBO1W8Ub022207@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012240132.oBO1W8Ub022207@imap1.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: akpm@linux-foundation.org
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, mm-commits@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12/24/2010 01:58 AM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2010-12-23-16-58 has been uploaded to

Hi, this kernel regresses with respect to suspend to ram in comparison
with mmotm 2010-12-16-14-56.

This is OK:
echo devices > /sys/power/pm_test
pm-suspend
This hangs at suspend phase:
echo platform > /sys/power/pm_test
pm-suspend

Note that this kernel is based on next-20101221. Should I try newer (and
clean) -next?

regards,
-- 
js
