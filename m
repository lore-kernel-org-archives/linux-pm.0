From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 20:25:15 +0300
Message-ID: <AANLkTinv5C-TO48ZMP0ZV-ne7VbCAhXlARhYOJmhYoRa__12032.5327422053$1274894823$gmane$org@mail.gmail.com>
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
	<AANLkTik9LINPmabJfVi0jfVs5sjVS_1l00WpnVTFEuLV@mail.gmail.com>
	<1274890736.4467.574.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274890736.4467.574.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Greg KH <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, tytso@mit.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi James,

On Wed, 2010-05-26 at 13:29 +0300, Pekka Enberg wrote:
>> Yup, I don't quite get Arve's argument either. C code can interact
>> with Java code (and vice versa) just fine in userspace.

On Wed, May 26, 2010 at 7:18 PM, James Bottomley
<James.Bottomley@suse.de> wrote:
> This is an incorrect statement. =A0It's possible for java to call C via
> the JNI, even though there are quite a few gotchas that mean not just
> *any* C code can do it (been there, tripped over some of them, although
> they were all ultimately ironed out). =A0It's very difficult for C to call
> directly into Java without being specially coded because it involves
> creating and managing a JVM (so in general, arbitrary C code can't do
> this). =A0The usual way we do C -> Java is process to process via some
> intermediary like RPC or Corba or SOAP (or even JSON) ... which gets
> very messy for a mobile device.

Incorrect statement how exactly? A JVM can do mmap(), for example,
just fine through FileChannel.map() so there's no need for
heavy-weight RPC. Furthermore, the whole discussion is moot anyway as
Android runs Dalvik which can be hacked to support whatever
communication mechanism is the best choice here.

So can we drop the whole "we need to do it in kernel because Java is
hard" nonsense and concentrate on real issues?

                               Pekka
