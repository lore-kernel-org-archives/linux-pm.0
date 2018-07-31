From: "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v4 0/4] Add the BQ25896 charger IC
Date: Tue, 31 Jul 2018 11:49:05 -0600
Message-ID: <20180731174909.9392-1-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Angus Ainslie (Purism)" <angus@akkea.ca>
List-Id: linux-pm@vger.kernel.org

Changes since v3:

Corrected reviewed-by tags.
Fix typos.
Clarify desscriptions of patches.

Changes since v2:

Remove additional un-used table entries.
Use the exsisting compitble string for the new part.
Voltage now doesn't depend on state "online".

Angus Ainslie (Purism) (4):
  power: bq25890_charger.c: Add debugging output of failed
    initialization
  power: bq25890_charger.c: Remove unused table entries
  power: bq25890_charger.c: Add the BQ25896 part
  power: bq25890_charger.c: Read back the current battery voltage

 .../bindings/power/supply/bq25890.txt         |  3 +
 drivers/power/supply/bq25890_charger.c        | 62 ++++++++++++++-----
 2 files changed, 50 insertions(+), 15 deletions(-)

-- 
2.17.1
