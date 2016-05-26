From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [patch v2] PM / devfreq: exynos-nocp: Remove incorrect IS_ERR() check
Date: Thu, 26 May 2016 23:10:08 +0900
Message-ID: <CAGTfZH31_OOSg-kJ1tp8pCv55nWZbcd6dG2zXrtov8BGh0udcw@mail.gmail.com>
References: <CGME20160526064612epcas1p4cb0d45fa11deafea51fa84974132afed@epcas1p4.samsung.com>
	<20160526064541.GA6680@mwanda>
	<5746AFE3.6030606@samsung.com>
	<20160526115629.GD10957@mwanda>
	<CAGTfZH2rqD_91D_Vt8EgXDO4ACJ-OKD5Os9RA4Mk7hg0EHzfcg@mail.gmail.com>
	<20160526135600.GE10957@mwanda>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20160526135600.GE10957@mwanda>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 26, 2016 at 10:56 PM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> On Thu, May 26, 2016 at 10:46:26PM +0900, Chanwoo Choi wrote:
>> On Thu, May 26, 2016 at 8:56 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> > On Thu, May 26, 2016 at 05:12:19PM +0900, Chanwoo Choi wrote:
>> >> I don't recommend that you mention the name of engineer on patch description
>> >> directly.
>> >
>> > This really is normal.  I've been mentioned over 100 times in commit
>> > messages like 7051924f771 (xillybus: Move out of staging).
>>
>> I'm still reluctant to use the name on description.
>
> I understand that but I don't understand why, though.  Anyway, aren't
> forwarding this to someone?  You can change it to say whatever you want.

Because if the name without any unique email address is included in
the description,
I think that it is not appropriate. Always, the information should
include the email address.
So, I just prefer to use the Suggested-by or the different kind of tag
with [id: explanation].

But, I'll stop about it because it is not critical issue.
It depend on what is the preferred method to add the information.

Thanks,
Chanwoo Choi
