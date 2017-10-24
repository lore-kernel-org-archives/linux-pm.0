From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: How to power gate a specific single device from outside?
Date: Tue, 24 Oct 2017 10:34:49 +0200
Message-ID: <CAHKzcEP6dQ1PxB35yCW_R1W8yZCCsJN_HqiZ6uq2d+sZp_9EYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi

I am looking for a convenient way to power gate specific single device
when the platform is running in backup mode - the platform lost main
power supply and it's on backup buttery now. The intention is to save
max power in backup mode and switch off all unnecessary blocks.

I could not find anything standard that let me power gate single
device from userland. Perhaps it's considered as a too risky operation
to expose to the user. I don't want to touch drivers too much as well
not to make them dependant on extra system feature. Better to have a
separate module that handles this system mode and forces some drivers
to unload/power gate their HW.

Are there already some proven solutions/ideas around the kernel that
can be used straight away?

Suggestions appreciated.

/Waldek
