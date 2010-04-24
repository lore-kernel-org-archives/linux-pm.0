From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 5/9] PM: suspend_block: Add debugfs file
Date: Fri, 23 Apr 2010 20:23:22 -0700
Message-ID: <n2rd6200be21004232023hf138c65dia5b378825124933d__38300.1620452434$1272079461$gmane$org@mail.gmail.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
	<1271984938-13920-4-git-send-email-arve@android.com>
	<1271984938-13920-5-git-send-email-arve@android.com>
	<1271984938-13920-6-git-send-email-arve@android.com>
	<20100423135853.478af057.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100423135853.478af057.randy.dunlap@oracle.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

2010/4/23 Randy Dunlap <randy.dunlap@oracle.com>:
> On Thu, 22 Apr 2010 18:08:54 -0700 Arve Hj=F8nnev=E5g wrote:
>
>> Report active and inactive suspend blockers in
>> /sys/kernel/debug/suspend_blockers.
>
>
> This looks more like user interface information than it does debug inform=
ation.
> If that's correct, it shouldn't be in debugfs.

Where should it be? It is not allowed in sysfs, and procfs does not
appear to be open to new files.

-- =

Arve Hj=F8nnev=E5g
