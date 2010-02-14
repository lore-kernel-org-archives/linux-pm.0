From: =?ISO-8859-1?Q?Erik_Andr=E9n?= <erik.andren@gmail.com>
Subject: Re: [PATCH 1/1] platform/x86/dell-laptop: Add another
	Dell laptop to the DMI whitelist
Date: Sun, 14 Feb 2010 20:07:56 +0100
Message-ID: <62e5edd41002141107n787920f0p15fd91add5eee5be__29268.8857451596$1266174538$gmane$org@mail.gmail.com>
References: <1266144897-2681-1-git-send-email-erik.andren@gmail.com>
	<20100214165528.GA25624@srcf.ucam.org>
	<62e5edd41002141059k5e06fc5o91b06e389d9609e3@mail.gmail.com>
	<20100214190431.GA28842@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100214190431.GA28842@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

2010/2/14 Matthew Garrett <mjg59@srcf.ucam.org>:
> On Sun, Feb 14, 2010 at 07:59:06PM +0100, Erik Andr=E9n wrote:
>
>> Darn, I forgot to add another module alias.
>> Shall I respin the whole patch or create another one depending on the ol=
d one?
>
> Oh, good point! I can add that myself and merge it in.
>

Thanks!
FWIW I've verified that the following string works:
MODULE_ALIAS("dmi:*svnDellComputerCorporation:*:ct8:*");

Best regards,
Erik

> --
> Matthew Garrett | mjg59@srcf.ucam.org
>
