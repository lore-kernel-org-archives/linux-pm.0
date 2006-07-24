From: Matthew Locke <matt@nomadgs.com>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Mon, 24 Jul 2006 12:40:54 -0700
Message-ID: <2af1156365fba2cb6217835d3ef4eda7@nomadgs.com>
References: <c55240ed0607201256q2d902a0nd3e9e3fba4ac9dd8@mail.gmail.com>
	<20060724172954.GC1926@elf.ucw.cz>
	<200607241149.01700.david-b@pacbell.net>
	<20060724193545.GA2806@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060724193545.GA2806@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: David Brownell <david-b@pacbell.net>, patrick.mochel@intel.com, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

On Jul 24, 2006, at 12:35 PM, Pavel Machek wrote:

>
>>> But better run this by lkml.
>>
>> I'd rather see some rough consensus on this list that this is the =

>> right way
>> to head, before running things like this by LKML.
>
> I meant "they could suggest how to do the sysfs thing, in reasonable
> way". Like echo new_config > file is extermely ugly, but perhaps =

> configfs
> is suitable?

Ah, Is that what you consider ugly, that each parameter is a sysfs file =

and the values have to be written to a file to set it up?

We can look into configfs and ask lkml (or specific people) for =

recommendations on the best mechanism to use.
