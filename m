From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/3] Thermal: dove: Convert to devm_ioremap_resource()
Date: Mon, 11 Mar 2013 17:07:08 +0530
Message-ID: <CAK9yfHwU21KBpcDBQv-YEeUhUno09CBjH-1df8O-B0MoDc7QFw@mail.gmail.com>
References: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
	<20130304070604.GE16261@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:34395 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab3CKLhJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Mar 2013 07:37:09 -0400
Received: by mail-oa0-f48.google.com with SMTP id j1so4254275oag.7
        for <linux-pm@vger.kernel.org>; Mon, 11 Mar 2013 04:37:08 -0700 (PDT)
In-Reply-To: <20130304070604.GE16261@avionic-0098.mockup.avionic-design.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org

Hi Zhang,

On 4 March 2013 12:36, Thierry Reding <thierry.reding@avionic-design.de> wrote:
> On Mon, Mar 04, 2013 at 12:15:32PM +0530, Sachin Kamat wrote:
>> Use the newly introduced devm_ioremap_resource() instead of
>> devm_request_and_ioremap() which provides more consistent error handling.
>>
>> devm_ioremap_resource() provides its own error messages; so all explicit
>> error messages can be removed from the failure code paths.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>
>
> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

Did you get a chance to review this series?


-- 
With warm regards,
Sachin
