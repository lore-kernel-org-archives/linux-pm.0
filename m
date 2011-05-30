From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: Re: idle patches for 2.6.40.merge
Date: Mon, 30 May 2011 13:42:08 +0530
Message-ID: <4DE35158.4030604@linux.vnet.ibm.com>
References: <1306662110-29954-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1306662110-29954-1-git-send-email-lenb@kernel.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Len,

Would the patch that completely removes pm_idle for x86
"cpuidle: stop using pm_idle" and the patch that introduces
bootparam cpuidle.off "cpuidle: create bootparam cpuidle.off=1"
be pushed as well?

Thanks
-Trinabh
