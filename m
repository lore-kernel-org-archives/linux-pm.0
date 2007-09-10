From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Subject: Re: Info on LDM, domain system and SOCs
Date: Mon, 10 Sep 2007 16:19:13 +0000
Message-ID: <46E56E81.2050105@st.com>
References: <46DEB51F.3010000@st.com>
	<1189430227.8343.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1189430227.8343.5.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

If you mean the <include/linux/clk.h>, I already saw it.
I think it's good but it isn't enough.
I want track also the devices on a clock to be able to notify (for each 
device) if a clock changes.


Igor Stoppa ha scritto:
> On Wed, 2007-09-05 at 13:54 +0000, ext Francesco VIRLINZI wrote:
>   
>> Hi all
>> I'm looking the Linux Driver Model (LDM) and the PM issues.
>>
>> I see the LDM is only "bus-oriented".
>> Is there an "official" reason why it doesn't track clock and voltage?
>>     
>
> Check the clock framework used by OMAP and other SoCs
>
>   
