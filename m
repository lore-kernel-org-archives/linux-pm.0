From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 13:16:18 +0200
Message-ID: <AANLkTimxXcupV0KX1nQIPbuRzZYXZwCebDVahxR-kWkJ__29390.7948573635$1274872659$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005251647530.1634-100000@iolanthe.rowland.org>
	<201005252344.37639.rjw@sisk.pl>
	<AANLkTimL5rU5lALezEZVCwdcZL85tVahhsTibdpq9s-Y@mail.gmail.com>
	<1274863342.5882.4850.camel@twins>
	<20100526112303.3fef15a4@schatten.dmk.lab>
	<1274866402.5882.5051.camel@twins>
	<AANLkTil9ZtMFxTfE6ITiFNOl4S1k3Lvdp5BPgGX7LJhw@mail.gmail.com>
	<1274868384.5882.5169.camel@twins>
	<AANLkTimHGpRAZklIwXu6wEbA3coKXJvCVLxj2twerkCw@mail.gmail.com>
	<1274869262.5882.5222.camel@twins>
	<AANLkTilp1zWqvmUzGjEX3x9OBsdXdvNEG-znTjVvoM-b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTilp1zWqvmUzGjEX3x9OBsdXdvNEG-znTjVvoM-b@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, tytso@mit.edu, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Florian Mickler <florian@mickler.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Greg KH <gregkh@suse.de>
List-Id: linux-pm@vger.kernel.org

2010/5/26 Arve Hj=F8nnev=E5g <arve@android.com>:
> 2010/5/26 Peter Zijlstra <peterz@infradead.org>:
>> On Wed, 2010-05-26 at 03:17 -0700, Arve Hj=F8nnev=E5g wrote:
>>> > With a single suspend manager process that manages the suspend state =
you
>>> > can achieve the same goal.
>>> >
>>>
>>> Yes we don't need the /dev interface, but it is useful. Without it any
>>> program that needs to block suspend has to make a blocking ipc call
>>> into the suspend manager process. Android already does this for java
>>> code, but system processes written in C block suspend directly with
>>> the kernel since they cannot use the java APIs.
>>
>> So provide a C interface to it as well?
>>
>
> We could, but the result would be that any program that needs to block
> suspend has to be android specific.

Just a suspicion, but... The things you're saying don't make sense to
me other than if you're fighting with GPL in userspace here.

~Vitaly
