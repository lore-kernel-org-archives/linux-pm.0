Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05E2D107;
	Mon,  4 Dec 2023 03:57:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B898152B;
	Mon,  4 Dec 2023 03:57:47 -0800 (PST)
Received: from [10.57.5.136] (unknown [10.57.5.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B8EA3F5A1;
	Mon,  4 Dec 2023 03:56:58 -0800 (PST)
Message-ID: <5ad40adf-aa79-4281-9cc3-2a1e7c10a356@arm.com>
Date: Mon, 4 Dec 2023 11:57:59 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Various Exynos targets never return to no cooling
From: Lukasz Luba <lukasz.luba@arm.com>
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20231113130451eucas1p293985c1bee8dc71b9c78a013663ce8e6@eucas1p2.samsung.com>
 <20231113130435.500353-1-m.majewski2@samsung.com>
 <93c5b287-a643-4e95-a38b-ed301d5cbcb2@arm.com>
Content-Language: en-US
In-Reply-To: <93c5b287-a643-4e95-a38b-ed301d5cbcb2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/14/23 10:32, Lukasz Luba wrote:
> Hi Mateusz,
> 
> On 11/13/23 13:04, Mateusz Majewski wrote:
>> Hi,
>>
>> While working on some fixes on the Exynos thermal driver, I have found 
>> that some
>> of the Exynos-based boards will never return to no cooling. That is, 
>> after
>> heating the board a bit and letting it cool, we see in the sysfs 
>> output similar
>> to this:
>>

Regarding this topic, I just wanted to tell you that I had conversation
with Rafael & Daniel last Fri. Rafael gave me a hint to his latest work
in his repo regarding potentially similar race with temperature value.

I'll have a look there and experiment next week, than come back to you.

Regards,
Lukasz
