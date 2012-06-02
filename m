From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/2] bug fixes for coupled cpuidle
Date: Sat, 02 Jun 2012 01:50:50 -0400
Message-ID: <4FC9A9BA.1020904@kernel.org>
References: <1337364324-12171-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1337364324-12171-1-git-send-email-ccross@android.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 05/18/2012 02:05 PM, Colin Cross wrote:

> The last modifications made to the coupled cpuidle patches introduced
> two bugs that I missed during testing.  The online count was never
> initialized, causing coupled idle to always wait and never enter the
> ready loop.  That hid the second bug, the ready count could never be
> decremented after exiting idle.
> 
> Len, these two patches could be squashed into patch 3 of the original
> set.  If you do squash them, you could also add Rafael's tags to the
> set (Reviewed-by on 1 and 2, acked-by on 3).


squash & tags update done.

> Or I can reupload the
> whole stack as v5 if you prefer.


no need.

thanks,
-Len Brown, Intel Open Source Technology Center
