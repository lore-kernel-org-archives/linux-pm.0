From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: Core PowerOP Interface Update [Was: Re: [RFC]
 PowerOP Take 3, ARM OMAP1 platform support 3/5]
Date: Thu, 03 Aug 2006 17:46:19 +0400
Message-ID: <44D1FE2B.3080207@gmail.com>
References: <c55240ed0607201301y7ac3be76o6f173d1b6ab50c1d@mail.gmail.com>	
	<200607261728.40443.david-b@pacbell.net>
	<44CD0937.6060905@gmail.com>	
	<200607301858.52096.david-b@pacbell.net>
	<44CFBEF0.2000700@gmail.com>	
	<c55240ed0608021907q7c3426fcj88bab45f66a6d729@mail.gmail.com>
	<acd2a5930608030426h56eb71cas4e7366f9602e7fc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <acd2a5930608030426h56eb71cas4e7366f9602e7fc2@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, patrick.mochel@intel.com, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

Vitaly Wool wrote:
> Eugeny,
>
> On 8/3/06, Eugeny S. Mints <eugeny.mints@gmail.com> wrote:
>> Please ignore the patch attached to the previous email and
>> consider current patch attached.
>>
>> This patch contains complete PowerOP Core layer rework.
>> Other patches follow shortly.
>
> Will anyone except drivers/powerop/powerop.c be using
> powerop_set_point/powerop_get_point? If yes, why?
The main reason is that a layer above PowerOP Core may want:
a) to use it's own method to reference operating points
and
b) implement another algorithm to maintain set of operating points
rather than use simple list algorithm provided by PowerOP Core
(for example due to performance reasons).

I assume that b) may be achieved in the future by implementing a
kind of algorithm plugins for PowerOP Core but  this will not
change already existed api and therefore this improvement may
be deferred for the time being.

The other minor reason is to allow smooth evolve of existed upper
layers (cpufreq): using powerop_set/get on the first step will require
less modification of existed code than leveraging named api .

It's reasonable to have powerop_get_point() exported for development
purposes as well since reasonable implementation of
powerop_get_named_active_opint() implies returning the result without
accessing underlying hw.

Thanks,
Eugeny
> If no, then why make
> them public?
>
> Thanks,
>   Vitaly
>
