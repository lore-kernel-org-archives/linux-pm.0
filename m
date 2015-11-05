From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v4 0/8] qcom: Add support for TSENS driver
Date: Thu, 05 Nov 2015 12:21:48 +0530
Message-ID: <563AFC84.3070807@codeaurora.org>
References: <1444383670-32693-1-git-send-email-rnayak@codeaurora.org>
 <20151102201345.GA4238@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151102201345.GA4238@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, punit.agrawal@arm.com, sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, lina.iyer@linaro.org, nrajan@codeaurora.org, agross@codeaurora.org, rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

On 11/03/2015 01:43 AM, Eduardo Valentin wrote:
> Rajendra,
> 
> On Fri, Oct 09, 2015 at 03:11:02PM +0530, Rajendra Nayak wrote:
>> Patches 1/8 to 4/8 will need to go via the thermal tree/Eduardo.
>> Patches 5/8 to 8/8 will need to go via qcom-msm tree/Andy.
>>
>> Eduardo, can you please take a look at the patches and let me
>> know if you see any issues.
>>
> 
> Thanks for your taking this over. I am assuming this superseeds the
> work by Narendran.

Yes, thats correct. I took Naren's work to add support for msm8960
family and created a single driver to work across msm8960 and
msm8974/8916/8084 SoCs.

regards,
Rajendra
