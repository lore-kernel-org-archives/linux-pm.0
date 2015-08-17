From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: max17042_battery: Support regmap to access device's registers
Date: Mon, 17 Aug 2015 17:08:54 +0300
Message-ID: <20150817140854.GB5610@mwanda>
References: <20150814095513.GA14436@mwanda>
 <CAJKOXPcjs+=gdzUUhkoYaOfnyWOFCfgg=XqKenK7GC46KBV-fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:39679 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbbHQOIo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2015 10:08:44 -0400
Content-Disposition: inline
In-Reply-To: <CAJKOXPcjs+=gdzUUhkoYaOfnyWOFCfgg=XqKenK7GC46KBV-fw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: jonghwa3.lee@samsung.com, linux-pm@vger.kernel.org

The static checker is just complaining about the cast...  I have looked
at it again and this code is definitely buggy.

max17042_read_model_data() reads u32s into tmp_data.
->cell_char_tbl is an array with 48 elements of u16.

We later assume that cell_char_tbl and temp_data have 48 bytes each when
we use memcmp() to compare them.  This only compares the first half of
->cell_char_tbl with the first quarter of tmp_data[].

Then we assume that they hold u16s when we print out the warning
message.

regards,
dan carpetner

