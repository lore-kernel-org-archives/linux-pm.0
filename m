From: Colin Cross <ccross@android.com>
Subject: [PATCH 0/2] bug fixes for coupled cpuidle
Date: Fri, 18 May 2012 11:05:22 -0700
Message-ID: <1337364324-12171-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <len.brown@intel.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Colin Cross <ccross@android.com>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The last modifications made to the coupled cpuidle patches introduced
two bugs that I missed during testing.  The online count was never
initialized, causing coupled idle to always wait and never enter the
ready loop.  That hid the second bug, the ready count could never be
decremented after exiting idle.

Len, these two patches could be squashed into patch 3 of the original
set.  If you do squash them, you could also add Rafael's tags to the
set (Reviewed-by on 1 and 2, acked-by on 3).  Or I can reupload the
whole stack as v5 if you prefer.
