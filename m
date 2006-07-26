From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: [RFC] PowerOP take 3, PowerOP core 1/5
Date: Thu, 27 Jul 2006 00:44:40 +0400
Message-ID: <44C7D438.6090208@gmail.com>
References: <c55240ed0607201250x5f77c473m381f1698f1168e52@mail.gmail.com>
	<200607201501.32087.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607201501.32087.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Matthew Locke <matt@nomadgs.com>, patrick.mochel@intel.com, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
> On Thursday 20 July 2006 12:50 pm, Eugeny S. Mints wrote:
>   =

>> +static int __init powerop_init(void)
>> +{
>> +       return 0;
>> +}
>> +
>> +static void __exit powerop_exit(void)
>> +{
>> +}
>> +
>> +module_init(powerop_init);
>> +module_exit(powerop_exit);
>>     =

>
> Best to delete useless code like that.  :)
>
> And you should be grabbing that mutex to register/unregister the arch
> methods table, otherwise there's little point in having it ...
>   =

basically agree. The reference code is handling only one arch layer
(essentially PM core) underneath PowerOP for the time being though.
At the same time PM Core is expected to be "aware" of all PM related
parameters and details so I actually would like to see an use case  showing
when an extra layer below PowerOP  may be useful to continue moving
towards multi arch layer approach.

Thanks,
Eugeny
