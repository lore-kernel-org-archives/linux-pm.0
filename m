From: david@lang.hm
Subject: Re: [PATCH] power: disable hibernation if module loading
 is disabled
Date: Sun, 6 Mar 2011 11:36:24 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1103061134520.9066@asgard.lang.hm>
References: <1299255084-4390-1-git-send-email-segoon@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1299255084-4390-1-git-send-email-segoon@openwall.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: Len Brown <len.brown@intel.com>, security@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 4 Mar 2011, Vasiliy Kulikov wrote:

> If /proc/sys/kernel/modules_disabled is set to 1, then nobody (even full
> root) may not read/write arbitrary kernel memory.  In spite of it,
> hibernation allows anyone with an access to either /dev/snapshot or
> /sys/power/ make the full snapshot of the system.  This snapshot may be
> freely changed and uploaded back.

given that the user can boot a different OS entirely and modify the stored 
image, I don't see how this can work, even conceptually.

and tieing anything modules related to hibernation is just wrong, you are 
mixing completely different concepts (even if the implementation happens 
to be similar)

David Lang
