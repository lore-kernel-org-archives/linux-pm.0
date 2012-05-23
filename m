From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH][v2] ARM: davinci: cpuidle - remove ops
Date: Wed, 23 May 2012 23:24:16 +0530
Message-ID: <4FBD2448.9010502@ti.com>
References: <1337551640-5973-1-git-send-email-daniel.lezcano@linaro.org>
	<4FBBD3CD.7070804@ti.com> <4FBBDD98.30105@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4FBBDD98.30105-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: khilman-l0cyMroinI0@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 5/23/2012 12:10 AM, Daniel Lezcano wrote:
> On 05/22/2012 07:58 PM, Sekhar Nori wrote:
>> Hi Daniel,
>>
>> On 5/21/2012 3:37 AM, Daniel Lezcano wrote:
>>> This patch removes the ops usage because we have the index
>>> passed as parameter to the idle function and we can determine
>>> if we do WFI or memory retention.
>>>
>>> The benefit of this cleanup is the removal of:
>>>   * the ops
>>>   * the statedata usage because we want to get rid of it in all the
>>> drivers
>>>   * extra structure definition
>>>   * extra functions definition
>>>   * remove macro definition using BIT(0)
>>>
>>> It also benefits the readability.
>>>
>>> Signed-off-by: Daniel Lezcano<daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> Looks good to me. If there is no other plan, I will queue these two
>> cpuidle patches for v3.6 through DaVinci tree.
> 
> Cool !
> 
> Just a reminder, I don't have this board, so I was not able to test it.

No problem. I tested that cpuidle enters state0 and state1 correctly
after this change. I did not make any power measurements though.

Thanks,
Sekhar
