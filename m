Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEECAAC;
	Wed, 13 Dec 2023 00:42:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 965ADC15;
	Wed, 13 Dec 2023 00:43:18 -0800 (PST)
Received: from [10.57.85.168] (unknown [10.57.85.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A10F3F762;
	Wed, 13 Dec 2023 00:42:31 -0800 (PST)
Message-ID: <ac47d127-a57a-4b93-a96c-2ced114dc554@arm.com>
Date: Wed, 13 Dec 2023 08:43:35 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] thermal: Use for_each_trip() in some places
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
References: <5733564.DvuYhMxLoT@kreacher>
 <CAJZ5v0hU12yWQstAFuDkid0iWxdh7biPy33BA8XfhczFWCVX5Q@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0hU12yWQstAFuDkid0iWxdh7biPy33BA8XfhczFWCVX5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 12/12/23 18:59, Rafael J. Wysocki wrote:
> On Mon, Dec 4, 2023 at 8:49 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> Hi,
>>
>> This series changes the code to use the for_each_trip() macro in a few
>> places instead of open-coded loops over trip indices.
> 
>  From the lack of comments I gather that the changes in this series are
> fine with everyone, so I'm going to queue it up for 6.8.
> 
> Thanks!
> 

Somehow I missed that series. Although, I've checked them today
and LGTM. So feel free to add my tag to thepatches if it's not too late:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
