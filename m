Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE9EEBB;
	Sat, 18 Jul 2026 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784337360; cv=none; b=NmERxW9LR3TElDQA9haCJQZzEBffaN6r+mjFGu1uBRMovw0nLj8+SoESVQyDyqZGMsqhN5EQR1Wi4yczX2bdMgA19t6QU8ljW6UrZ6w46Lmn1Xt/nmV3ycl1PSrjM3Jil3RZhrKvzQfLAOQTM/bXNEt6iPERZsLb5tDoL/7BV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784337360; c=relaxed/simple;
	bh=HMEiEKRyrlVeI4n96MFVWZNhD7UgL9b2ux929+71Tjg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gQNs/YidXpTMtFRlc1LLwRslftVK9+H1Pap/Qk0xdXmu7qLlyFqdbxxl0nHJ6C88YOvtPO8FjRc3OC6Jj9KAT0X7HrACXIJI/TAgL100sSqJ89n5+5mKO1BnHsDz8taDaApwy+sbkYvlARvk2wBM/fUvonU5MUA4yYCbiBchEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B5E1F000E9;
	Sat, 18 Jul 2026 01:15:58 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 132EA181D34; Sat, 18 Jul 2026 03:15:56 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, 
 Saravanan Sekar <sravanhome@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Samuel Kayode <samkay014@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, Pan Chuang <panchuang@vivo.com>
In-Reply-To: <20260709033428.362970-1-panchuang@vivo.com>
References: <20260709033428.362970-1-panchuang@vivo.com>
Subject: Re: [PATCH 00/43] power: Remove redundant error messages on IRQ
 request failure
Message-Id: <178433735604.414021.16202847796535992443.b4-ty@collabora.com>
Date: Sat, 18 Jul 2026 03:15:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 09 Jul 2026 11:33:39 +0800, Pan Chuang wrote:
> Commit 55b48e23f5c4b6f5ca9b7ab09599b17dcf501c10 ("genirq/devres: Add
> error handling in devm_request_*_irq()") added automatic error logging
> to devm_request_threaded_irq() and devm_request_any_context_irq() via
> the new devm_request_result() helper. The helper prints device name,
> IRQ number, handler functions, and error code on failure.
> 
> Since devm_request_irq() is a static inline wrapper around
> devm_request_threaded_irq(), it also benefits from this automatic
> logging.
> 
> [...]

Applied, thanks!

[01/43] power: reset: pwr-mlxbf: Remove redundant dev_err()/dev_err_probe()
        commit: e896e0d29ba30d462176c7611399c10297a6845f
[02/43] power: supply: 88pm860x_battery: Remove redundant dev_err()/dev_err_probe()
        commit: 098e2181f76fbcdd1592c1878a812bc9dbadc669
[03/43] power: supply: 88pm860x_charger: Remove redundant dev_err()/dev_err_probe()
        commit: a446886a5c112d6a7d019161cf520b1d6f10470f
[04/43] power: supply: ab8500_btemp: Remove redundant dev_err()/dev_err_probe()
        commit: 2865c7e80aee424a5266f8d089f7926394fe2d7c
[05/43] power: supply: ab8500_charger: Remove redundant dev_err()/dev_err_probe()
        commit: defdb28de9b3afb4811423a302ff11526595d098
[06/43] power: supply: ab8500_fg: Remove redundant dev_err()/dev_err_probe()
        commit: aa5f4decedfb4fc5cd0fe49ab256ad4304d192e4
[07/43] power: supply: act8945a_charger: Remove redundant dev_err()/dev_err_probe()
        commit: 88a66a3c93fe21f8fb6904a2ef95d53e637b355b
[08/43] power: supply: axp20x_ac_power: Remove redundant dev_err()/dev_err_probe()
        commit: daa60df947f41198defb37acef01b0c6cb819056
[09/43] power: supply: axp20x_usb_power: Remove redundant dev_err()/dev_err_probe()
        commit: d8b7f5b39c3487349f77676a78e44093ec42b7c4
[10/43] power: supply: axp288_charger: Remove redundant dev_err()/dev_err_probe()
        commit: 5ec359933b7cd110e35aa298438cc4beeff5cc4b
[11/43] power: supply: axp288_fuel_gauge: Remove redundant dev_err()/dev_err_probe()
        commit: dfb7997da1df482f29d19b18071bd9a18f35704c
[12/43] power: supply: bq24190_charger: Remove redundant dev_err()/dev_err_probe()
        commit: 6d5c4deea04580a08ad1ed3a13c11fac0dbefa7b
[13/43] power: supply: bq24257_charger: Remove redundant dev_err()/dev_err_probe()
        commit: 1fa348a2a1825a23ab7836671f067640c98174bd
[14/43] power: supply: bq24735-charger: Remove redundant dev_err()/dev_err_probe()
        commit: d77b6dd6903da71896aa20863ee51df7f54b9e7c
[15/43] power: supply: bq256xx_charger: Remove redundant dev_err()/dev_err_probe()
        commit: 4f22a6bd5130779014d19a9946bda07768325930
[16/43] power: supply: bq257xx_charger: Remove redundant dev_err()/dev_err_probe()
        commit: c1de2a3f1f4170105db56003be42c079dbc264dc
[17/43] power: supply: cpcap-battery: Remove redundant dev_err()/dev_err_probe()
        commit: fb5ce24c6e907165022a7df627bdf573d2c8fd1f
[18/43] power: supply: cpcap-charger: Remove redundant dev_err()/dev_err_probe()
        commit: 16447b9ef408768d94b9b15b589f287eb8ff2127
[19/43] power: supply: da9150-fg: Remove redundant dev_err()/dev_err_probe()
        commit: 79993fd38d1848c4cfc5d51b185c534cc4ed0b87
[20/43] power: supply: generic-adc-battery: Remove redundant dev_err()/dev_err_probe()
        commit: 9c6283da58db46a0cc747c87d187939fb53aa326
[21/43] power: supply: max14656_charger_detector: Remove redundant dev_err()/dev_err_probe()
        commit: 5fe1b9dfa5c3c51a9d4d68b407ad9c49096e4b3e
[22/43] power: supply: max77759_charger: Remove redundant dev_err()/dev_err_probe()
        commit: 05c9bf35a036944171344711e664e032bf518e08
[23/43] power: supply: max8903_charger: Remove redundant dev_err()/dev_err_probe()
        commit: 28b94b06c64a1b423e64357f4c2cf3256f3a35f7
[24/43] power: supply: max8971_charger: Remove redundant dev_err()/dev_err_probe()
        commit: 342b3ce23061ff9ad5c033596c60a663d15af116
[25/43] power: supply: mp2629_charger: Remove redundant dev_err()/dev_err_probe()
        commit: f73b8c7c3ee61e08819a688bef98c8c454b6d4d5
[26/43] power: supply: mt6360_charger: Remove redundant dev_err()/dev_err_probe()
        commit: 576014dbc39716304c7ee22dc5c0998222ae6676
[27/43] power: supply: mt6370-charger: Remove redundant dev_err()/dev_err_probe()
        commit: 1a3d312038e6e1d19b8fd9146fc544f09336c8bd
[28/43] power: supply: pf1550-charger: Remove redundant dev_err()/dev_err_probe()
        commit: 4fed9665ab09cb7c40f894506b8ee2730ed9f3e1
[29/43] power: supply: qcom_smbb: Remove redundant dev_err()/dev_err_probe()
        commit: cd05fa1ffae4e21c520b64e203f50b7d76d35a4f
[30/43] power: supply: qcom_smbx: Remove redundant dev_err()/dev_err_probe()
        commit: c01b2be3845ffae11a067cf93a7833ca840d7d1c
[31/43] power: supply: rk817_charger: Remove redundant dev_err()/dev_err_probe()
        commit: 6d5c18483f0cf12eb636dcf46be452054f3aef4f
[32/43] power: supply: rn5t618_power: Remove redundant dev_err()/dev_err_probe()
        commit: a69f6b1e30f72c5fdeab81319c378ebb6e539803
[33/43] power: supply: rt9455_charger: Remove redundant dev_err()/dev_err_probe()
        commit: 406b652bf9c47d6e784fd2ab723e6798d322ef47
[34/43] power: supply: rt9467-charger: Remove redundant dev_err()/dev_err_probe()
        commit: 1683815ef8892a56c2e07548b879f341bfda2952
[35/43] power: supply: rt9471: Remove redundant dev_err()/dev_err_probe()
        commit: 94f491a228bdde8982a3fd72cd1d46b12eef378e
[36/43] power: supply: sbs-charger: Remove redundant dev_err()/dev_err_probe()
        commit: bfae8c8ad5adc1796d7982feb2dd4a0bd947ba84
[37/43] power: supply: sc27xx_fuel_gauge: Remove redundant dev_err()/dev_err_probe()
        commit: 139c9e37448d215647d8c1a98974c0d8309af1de
[38/43] power: supply: surface-rt-ec: Remove redundant dev_err()/dev_err_probe()
        commit: 4e8ef72bbd3ef34e1137d365e7719399f45d5c0b
[39/43] power: supply: tps65090-charger: Remove redundant dev_err()/dev_err_probe()
        commit: ceaee7db26ffaeb78b64df9f21be4a1c7823793a
[40/43] power: supply: tps65217_charger: Remove redundant dev_err()/dev_err_probe()
        commit: abd5cd2d712cae2a7abc3852d9fbd05696d4b9eb
[41/43] power: supply: twl4030_charger: Remove redundant dev_err()/dev_err_probe()
        commit: ca5cb9488b800a5b39954391530244da41076f79
[42/43] power: supply: twl6030_charger: Remove redundant dev_err()/dev_err_probe()
        commit: c2d8a2b01bef42f4e50a87e5880f75401be1290c
[43/43] power: supply: ucs1002_power: Remove redundant dev_err()/dev_err_probe()
        commit: 5a6b9c36c56340812d49817524a5d96f7522c74d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

