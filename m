From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [RFC PATCH 2/2] thermal: Add generic cpu cooling implementation
Date: Mon, 16 Jan 2012 08:13:16 -0600
Message-ID: <CAMXH7KGR7UCc42TJrVyR7WehDCHczOL2NCnZQe7giLXccF3RbA@mail.gmail.com>
References: <1323789196-4942-1-git-send-email-amit.kachhap@linaro.org>
	<1323789196-4942-3-git-send-email-amit.kachhap@linaro.org>
	<CAMXH7KEBCTWDsSFn+ZUsbetvbWXO3N9ZMpLBvLm0n0r2RH1wuQ@mail.gmail.com>
	<CAK44p203s3Eg8n2C_SXiFDEOsL3hQ2J34e0kFE9T=Um6kFZd1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAK44p203s3Eg8n2C_SXiFDEOsL3hQ2J34e0kFE9T=Um6kFZd1Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Amit Kachhap <amit.kachhap@linaro.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

>> I don't like how ACTIVE does not have available notification callbac=
ks
>> like HOT and CRITICAL do. =A0Perhaps I fail to grasp why they aren't=
 there
>> but besides just applying a cooling device, one might want to do som=
ething
>> else as well upon hitting these trip points. =A0So that said, it mig=
ht be nice
>> to add a notification to STATE_ACTIVE as well.
> Well I added ACTIVE_STATE trip type as just some additional features
> over trip type ACTIVE. Also each thermal zone can have more then one
> trip types so HOT notifications can still be used. But I like your
> suggestion of putting notfications in all the trip types. Lets see if
> the maintainers agree to this idea.
Thinking about it a bit more, I didn't consider HOT because it only
notifies when you cross above this trip point and not below and the
use case I had in mind would ideally want to be notified in both
cases.  Also, if ACTIVE/ACTIVE_STATE trip types will always have
cooling devices bound to them, then the notification could be put in
the cooling device code if desired.  I think these features are
separate from your main effort and can be addressed in separate future
patch.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
