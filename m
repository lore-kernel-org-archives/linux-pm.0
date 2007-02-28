From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Wed, 28 Feb 2007 23:40:29 +0200
Message-ID: <20070228214029.GB4357@mellanox.co.il>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
	<20070226220152.GA29575@stusta.de>
	<20070228211318.GB4301@mellanox.co.il>
	<1172698026.11473.40.camel@localhost.localdomain>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1172698026.11473.40.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>Quoting Thomas Gleixner <tglx@linutronix.de>:
>Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
>
>On Wed, 2007-02-28 at 23:13 +0200, Michael S. Tsirkin wrote:
>> >Subject    : ThinkPad T60: no screen after suspend to RAM
>> >References : http://lkml.org/lkml/2007/2/22/391
>> >Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
>> >Handled-By : Ingo Molnar <mingo@elte.hu>
>> >Status     : unknown
>> =

>> Just reproduced this in -rc2.
>> Another thing I noticed:
>> with 2.6.20, pressing Fn/F4 generates an ACPI event and triggers suspend=
 to RAM.
>> =

>> On 2.6.21-rc2, after resume (when the box is accessible from network),
>> pressing Fn/F4 again does not seem to have any effect.
>
>Can you please get the dmesg output after resume via the network ?

The link above has it.

-- =

MST
