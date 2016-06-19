From: Chris Lapa <chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>
Subject: [PATCH v4 0/7] max8903: Add device tree support and misc fixes
Date: Mon, 20 Jun 2016 08:27:15 +1000
Message-ID: <1466375242-38354-1-git-send-email-chris@cpdesign.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464849897-21527-3-git-send-email-chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>
In-Reply-To: <1464849897-21527-3-git-send-email-chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>
References: <1464849897-21527-3-git-send-email-chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Lapa <chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Chris Lapa <chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>

This patch set adds device tree support for the MAX8903 battery charger.
It also cleans up logic with dc_valid, dok and dcm pins as well as
fixing up validity checking of gpios.

I verified these patches work on a board I have here, which uses the
DC power side (not the USB portition) of the MAX8903.

Changes v3 -> v4:
 * Fixed formatting, such as multiline strings and indentation mistakes
 * Moved gpio setup code into max8903_setup_gpios() in 3/7
 * Fixed typo in 5/7
 * Renamed of_node to np in 7/7

Changes v2 -> v3:
 * Separate requesting of gpio's into its own commit
 * Fixed up validity checking of GPIO's
 * Remove dc_valid and usb_valid from device tree
 * Remove some unncessary init to psy_cfg.num_supplicants and psy_cfg.supplied_to
 * Reorder patches so device tree implementation is final patch

Changes v1 -> v2:
 * Separate DT bindings documentation into its own commit
 * Add maxim prefix to DT compatible field
 * Add gpios suffix to gpio's in DT
 * Remove malloc failed error message

Chris Lapa (7):
  max8903: adds documentation for device tree bindings.
  max8903: store pointer to pdata instead of copying it.
  max8903: cleans up confusing relationship between dc_valid, dok and
    dcm.
  max8903: adds requesting of gpios.
  max8903: removes non zero validity checks on gpios.
  max8903: remove unnecessary 'out of memory' error message.
  max8903: adds support for initiation via device tree

 .../devicetree/bindings/power/max8903-charger.txt  |  25 +++
 drivers/power/max8903_charger.c                    | 239 +++++++++++++++------
 include/linux/power/max8903_charger.h              |   6 +-
 3 files changed, 204 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/max8903-charger.txt

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
