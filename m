From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] Hibernate runtime-resume fixes
Date: Wed, 23 Mar 2016 22:42:02 +0100
Message-ID: <2065134.sandJm4dU7@vostro.rjw.lan>
References: <cover.1458641423.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1458641423.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 23, 2016 12:11:20 AM Lukas Wunner wrote:
> I stumbled across these two issues while implementing runtime pm for
> Thunderbolt. Unfortunately hibernate is not working on my machine
> (no swap partition) so I could not test the patches beyond verifying
> that they compile. I merely had the impression that this is wrong
> when reading the code. Somebody please double-check if the patches
> are legitimate. If they are not then I apologize for the noise.

Both are legitimate in my view, so I've applied them and marked them for
"stable".

The subject of the second one is slightly not to the point (as this is
more about telling drivers that platform firmware has been involved
in the resume operation, which may or may not be related to runtime
resuming them etc), but then I can't invent a better one anyway.

Thanks,
Rafael

