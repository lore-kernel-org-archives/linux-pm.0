From: fanderay <fanderay4@googlemail.com>
Subject: Re: [Regression] sony-laptop breaks resume from S2RAM
	(was: Re: Resume after suspend-to-ram broken for Vaio SR19VN
	in 30rc2)
Date: Wed, 22 Apr 2009 21:35:13 +0100
Message-ID: <31c940650904221335v21fbffc2y2e9598b564d65659__45667.8564231426$1240432820$gmane$org@mail.gmail.com>
References: <31c940650904201152y5f440237rb9c49f1aedfef5a6@mail.gmail.com>
	<200904212050.25531.rjw@sisk.pl>
	<31c940650904220555v1c1a6046ifa40b9c81b390731@mail.gmail.com>
	<200904222202.24271.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904222202.24271.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Mattia Dongili <malattia@linux.it>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 22, 2009 at 9:02 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> Hi Rafael,
>>
>> I found the problem: it's the Sony laptop driver. =A0With
>> CONFIG_SONY_LAPTOP=3Dy, the hard freeze on resume occurs. =A0Without this
>> driver in the kernel, resume after s2ram -f -p appears to work
>> correctly.
>
> It seems to be an ACPI problem, then. =A0Added some CCs.

Thanks, I raised bug <http://bugzilla.kernel.org/show_bug.cgi?id=3D13148>.

> Thanks,
> Rafael
