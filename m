From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] [PATCH 0/2] bug fixes for coupled cpuidle
Date: Tue, 05 Jun 2012 11:12:28 -0700
Message-ID: <878vg1eigj.fsf@ti.com>
References: <1337364324-12171-1-git-send-email-ccross@android.com>
	<4FC9A9BA.1020904@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FC9A9BA.1020904@kernel.org> (Len Brown's message of "Sat, 02
	Jun 2012 01:50:50 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Colin Cross <ccross@android.com>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Len,

Len Brown <lenb@kernel.org> writes:

> On 05/18/2012 02:05 PM, Colin Cross wrote:
>
>> The last modifications made to the coupled cpuidle patches introduced
>> two bugs that I missed during testing.  The online count was never
>> initialized, causing coupled idle to always wait and never enter the
>> ready loop.  That hid the second bug, the ready count could never be
>> decremented after exiting idle.
>> 
>> Len, these two patches could be squashed into patch 3 of the original
>> set.  If you do squash them, you could also add Rafael's tags to the
>> set (Reviewed-by on 1 and 2, acked-by on 3).
>
>
> squash & tags update done.
>
>> Or I can reupload the
>> whole stack as v5 if you prefer.
>
>
> no need.

Hmm, after the problems with the pull request, it looks like you dropped
the coupled CPUidle series completely.  It's a shame that this has been
reviewed, tested and queued for so long only to see it dropped at the
last minute.

Instead of the squash, could you just queue the original series (that
has been in linux-next for some time) and then submit the fixes in
$SUBJECT series for v3.5-rc?  That way we could still get this support
in for 3.5, which many of us are waiting for.

Thanks,

Kevin
