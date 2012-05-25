From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] [PATCH 0/2] bug fixes for coupled cpuidle
Date: Fri, 25 May 2012 15:38:56 -0700
Message-ID: <87fwanj37j.fsf@ti.com>
References: <1337364324-12171-1-git-send-email-ccross@android.com>
 <4FB9E461.9060405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FB9E461.9060405@ti.com> (Santosh Shilimkar's message of "Mon,
 21 May 2012 12:14:49 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Colin Cross <ccross@android.com>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Len,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Friday 18 May 2012 11:35 PM, Colin Cross wrote:
>> The last modifications made to the coupled cpuidle patches introduced
>> two bugs that I missed during testing.  The online count was never
>> initialized, causing coupled idle to always wait and never enter the
>> ready loop.  That hid the second bug, the ready count could never be
>> decremented after exiting idle.
>> 
>> Len, these two patches could be squashed into patch 3 of the original
>> set.  If you do squash them, you could also add Rafael's tags to the
>> set (Reviewed-by on 1 and 2, acked-by on 3).  Or I can reupload the
>> whole stack as v5 if you prefer.
>
> I confirm that these two fixes are needed to get couple idle
> v4 series working.

Tested-by: Kevin Hilman <khilman@ti.com>

Can you pick these up for v3.6?

I don't currently see them in your next branch.

Thanks,

Kevin
