From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 00/15][Sorted-buddy] mm: Memory Power Management
Date: Thu, 25 Apr 2013 23:27:12 +0530
Message-ID: <51796E78.20203@linux.vnet.ibm.com>
References: <20130409214443.4500.44168.stgit@srivatsabhat.in.ibm.com> <517028F1.6000002@sr71.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:34080 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933155Ab3DYSAU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Apr 2013 14:00:20 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 25 Apr 2013 23:25:51 +0530
In-Reply-To: <517028F1.6000002@sr71.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Hansen <dave@sr71.net>
Cc: akpm@linux-foundation.org, mgorman@suse.de, matthew.garrett@nebula.com, rientjes@google.com, riel@redhat.com, arjan@linux.intel.com, srinivas.pandruvada@linux.intel.com, maxime.coquelin@stericsson.com, loic.pallardy@stericsson.com, kamezawa.hiroyu@jp.fujitsu.com, lenb@kernel.org, rjw@sisk.pl, gargankita@gmail.com, paulmck@linux.vnet.ibm.com, amit.kachhap@linaro.org, svaidy@linux.vnet.ibm.com, andi@firstfloor.org, wujianguo@huawei.com, kmpark@infradead.org, thomas.abraham@linaro.org, santosh.shilimkar@ti.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On 04/18/2013 10:40 PM, Dave Hansen wrote:
> On 04/09/2013 02:45 PM, Srivatsa S. Bhat wrote:
>> 2. Performance overhead is expected to be low: Since we retain the s=
implicity
>>    of the algorithm in the page allocation path, page allocation can
>>    potentially remain as fast as it would be without memory regions.=
 The
>>    overhead is pushed to the page-freeing paths which are not that c=
ritical.
>=20

[...]
=20
> I still also want to see some hard numbers on:
>> However, memory consumes a significant amount of power, potentially =
upto
>> more than a third of total system power on server systems.

Please find below, the reference to the publicly available paper I had =
in
mind, when I made that statement:

C. Lefurgy, K. Rajamani, F. Rawson, W. Felter, M. Kistler, and Tom Kell=
er.
Energy management for commercial servers. In IEEE Computer, pages 39=E2=
=80=9348,
Dec 2003.

Here is a quick link to the paper:
researcher.ibm.com/files/us-lefurgy/computer2003.pdf

On page 40, the paper shows the power-consumption breakdown for an IBM =
p670
machine, which shows that as much as 40% of the system energy is consum=
ed by
the memory sub-system in a mid-range server.

I admit that the paper is a little old (I'll see if I can find anything=
 more
recent that is publicly available, or perhaps you can verify the same i=
f you
have data-sheets for other platforms handy), but given the trend of inc=
reasing
memory speeds and increasing memory density/capacity in computer system=
s, the
power-consumption of memory is certainly not going to become insignific=
ant all
of a sudden.

IOW, the above data supports the point I was trying to make - Memory ha=
rdware
contributes to a significant portion of the power consumption of a syst=
em. And
since the hardware is now exposing ways to reduce the power consumption=
, it
would be worthwhile to try and exploit it by doing memory power managem=
ent.

Regards,
Srivatsa S. Bhat

