From: =?ISO-8859-1?Q?Erik_Andr=E9n?= <erik.andren@gmail.com>
Subject: Re: [PATCH 1/1] platform/x86/dell-laptop: Add another
	Dell laptop to the DMI whitelist
Date: Sun, 14 Feb 2010 19:59:06 +0100
Message-ID: <62e5edd41002141059k5e06fc5o91b06e389d9609e3__23761.0472985127$1266174010$gmane$org@mail.gmail.com>
References: <1266144897-2681-1-git-send-email-erik.andren@gmail.com>
	<20100214165528.GA25624@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100214165528.GA25624@srcf.ucam.org>
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
> On Sun, Feb 14, 2010 at 11:54:57AM +0100, Erik Andren wrote:
>> The Latitude C640 has another variation of dell in its DMI vendor entry.
>> Add it to the whitelist in order to enjoy the sweet fruits of software backlight toggling.
>
> Thanks, picked up for .34.
>

Darn, I forgot to add another module alias.
Shall I respin the whole patch or create another one depending on the old one?

Best regards,
Erik

> --
> Matthew Garrett | mjg59@srcf.ucam.org
>
