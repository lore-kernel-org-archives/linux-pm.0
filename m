From: "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 0/4] Add the BQ25896 charger IC
Date: Wed, 25 Jul 2018 13:46:26 -0600
Message-ID: <20180725194630.10414-1-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Angus Ainslie (Purism)" <angus@akkea.ca>
List-Id: linux-pm@vger.kernel.org

Revised patch set based on review comments

Angus Ainslie (Purism) (4):
  power: bq25890_charger.c: Add debugging output of failed
    initialization
  power: bq25890_charger.c: Remove unused table
  power: bq25890_charger.c: Add the BQ25896 part
  power: bq25890_charger.c: Read back the current battery voltage

 .../bindings/power/supply/bq25890.txt         |  1 +
 drivers/power/supply/bq25890_charger.c        | 65 +++++++++++++++----
 2 files changed, 54 insertions(+), 12 deletions(-)

-- 
2.17.1
